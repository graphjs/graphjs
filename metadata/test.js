const metadata = require('.');

testcases = [
    'Content without metadata',
    'Some content [metadata](type=file-size;key={http://www.example.com/image.png};value={34})asdasd',
    'Some content '
        + '[metadata](type=file-size;key={http://www.example.org/image.jpg};value={123})'
        + 'asdasd[metadata](type=original-filename;key={http://www.example.net/image.gif};value={})',
    'Some content [metadata](type=abc;key={b\\}};value={c\\}\\}})',
    '[metadata](type=abc;key={b\\}};value={c\\})',
    'Nice Video [video](http://example.com/video{1123}.mp4)'
        + '\n'
        + '[metadata](type=video-preview;key={http://example.com/video\\{1123\\}.mp4};value={http://example.com/video\\{1123\\}-preview.jpg})',
];

console.log(testcases.map(testcase => metadata.decode(testcase)));
// console.log(JSON.stringify(testcases.map(testcase => metadata.decode(testcase))));

testcases = [
    {
        'content': 'Nice Video [video](http://example.com/video{1123}.mp4)',
        'metadata': [
            {
                'type': 'video-preview',
                'key': 'http://example.com/video{1123}.mp4',
                'value': 'http://example.com/video{1123}-preview.jpg',
            },
        ],
    },
    {
        'content': 'Some content',
        'metadata': [],
    },
];

console.log(testcases.map(testcase => metadata.encode(testcase)));
