<?php

// Require the Faker autoloader
require_once 'vendor/autoload.php';

//Set server
$server = "http://phonetworks.com:1338";

//Set public id
$publicId = "79982844-6a27-4b3b-b77f-419a79be0e10";

function run() {
    
// Create a client
$client = new \GuzzleHttp\Client();

// Create a cookie jar
$jar = new \GuzzleHttp\Cookie\CookieJar;

// Create a Faker instance
$faker = Faker\Factory::create();

//Generate a birthday
date_default_timezone_set('Europe/Istanbul');
$date = $faker->dateTimeThisCentury->format('m/d/Y');
list($month, $day, $year) = preg_split('[/.-]', $date);
if($year > date("Y") - 13) {
    $year = date("Y") - 13 - 1;
}

//Choose gender
$genderOptions = array("men", "women");
$gender = $genderOptions[rand() % count($genderOptions)];

// Generate data
$fixed = new stdClass();
$fixed->username = rawurlencode(substr(str_replace(".", "", $faker->firstName($gender).$faker->lastName), 0, 12));
$fixed->email = $faker->email;
$fixed->password = "12345678";
$fixed->birthday = $month."/".$day."/".$year;
$fixed->avatar = "https://randomuser.me/api/portraits/med/".$gender."/".rand(0, 99).".jpg";
$fixed->url = "http://docs.graphjs.com";

//Function to create request
function call($method, $query, $message) {
    $query["public_id"] = $GLOBALS["publicId"];
    echo "REQUEST: ";
    var_dump(json_encode($query, JSON_NUMERIC_CHECK | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT));
    echo "<br /><br />";
    // Send the request
    $response = $GLOBALS["client"]->request("GET", $GLOBALS["server"]."/".$method, [
        "query" => http_build_query($query),
        "cookies" => $GLOBALS["jar"]
    ]);
    $body = json_decode($response->getBody());
    check($response->getStatusCode() == "200" && $body->success, $message);
    echo "RESPONSE: ";
    var_dump(json_encode($body, JSON_NUMERIC_CHECK | JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES | JSON_PRETTY_PRINT));
    echo "<br /><br />";
    echo "<hr />";
    echo "<br /><br />";
    return $body;
}

//Function to track progress
function check($statement, $message) {
    if($statement) {
        echo "SUCCESS: ".$message."<br /><br />";
    } else {
        echo "FAIL: ".$message."<br /><br />";
        exit;
    }
}


//Register new user
$signupCall = call(
    "signup",
    [
        "username" => $fixed->username,
        "email" => $fixed->email,
        "password" => $fixed->password
    ],
    "Register new user"
);

//Get user id
check(isset($signupCall->id), "Get user id");
$fixed->id = $signupCall->id;

//Login as the user
call(
    "login",
    [
        "username" => $fixed->username,
        "password" => $fixed->password
    ],
    "Login as the user"
);

//Set profile details
$signupCall = call(
    "setProfile",
    [
        "about" => $faker->catchPhrase,
        "birthday" => $fixed->birthday,
        "avatar" => $fixed->avatar
    ],
    "Set profile details"
);

//Star main page
call(
    "star",
    [
        "url" => $fixed->url
    ],
    "Star main page"
);

//Comment on main page
call(
    "addComment",
    [
        "url" => $fixed->url,
        "content" => $faker->realText($faker->numberBetween(10, 100))
    ],
    "Comment on main page"
);

//Get all members
$getUsersCall = call(
    "getMembers",
    [],
    "Get all members"
);
check(isset($getUsersCall->members), "Get all member ids");
$members = $getUsersCall->members;
$fixed->members = array_keys(get_object_vars($members));

//Follow all the members
foreach($fixed->members as $member) {
    if($member != $fixed->id) {
        call(
            "follow",
            [
                "id" => $member
            ],
            "Follow ".$member
        );
    }
}

//Message all the members
foreach($fixed->members as $member) {
    call(
        "sendMessage",
        [
            "to" => $member,
            "message" => substr($faker->sentences($nb = 5, $asText = true), 0, 255)
        ],
        "Send message to ".$member
    );
}

//Start new thread
call(
    "startThread",
    [
        "title" => $faker->sentence($nbWords = 3, $variableNbWords = true),
        "message" => $faker->sentences($nb = 10, $asText = true)
    ],
    "Start new thread"
);

//Get all threads
$getThreadsCall = call(
    "getThreads",
    [],
    "Get all threads"
);
check(isset($getThreadsCall->threads), "Get all thread ids");
$threads = $getThreadsCall->threads;
$fixed->threads = array();
foreach($threads as $thread) {
    array_push($fixed->threads, $thread->id);
}

//Reply to all the threads
foreach($fixed->threads as $thread) {
    call(
        "reply",
        [
            "id" => $thread,
            "message" => substr($faker->sentences($nb = 5, $asText = true), 0, 255)
        ],
        "Reply to ".$thread
    );
}

//Create new group
$createGroupCall = call(
    "createGroup",
    [
        "title" => $faker->company,
        "description" => $faker->catchPhrase
    ],
    "Create new group"
);

//Get group id
check(isset($createGroupCall->id), "Get group id");
$fixed->group = $createGroupCall->id;

//Get all groups
$listGroupsCall = call(
    "listGroups",
    [],
    "Get all groups"
);
check(isset($listGroupsCall->groups), "Get all group ids");
$groups = $listGroupsCall->groups;
$fixed->groups = array();
foreach($groups as $group) {
    array_push($fixed->groups, $group->id);
}
//Join all the groups
foreach($fixed->groups as $group) {
    if($group != $fixed->group) {
        call(
            "join",
            [
                "id" => $group
            ],
            "Joined ".$group
        );
    }
}
    
}

$max = 24;
if(isset($argv[1]&&is_numeric($argv[1]))
    $max = (int) $argv[1];

for($i=0;$i<24;$i++) {
    run();
}

?>
