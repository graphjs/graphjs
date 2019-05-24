# GraphJS

GraphJS is a Javascript client-side library to help developers easily enable social features on their web sites. GraphJS is built upon the [Phở framework](https://github.com/phonetworks/pho-microkernel), and it's open source. With only a few lines of code, you can easily add authentication, comments, messages, forum, groups, profiles etc. to your static web pages. 

GraphJS depends on [Riot.js](https://riot.js.org/). 

## Building

Make sure you have [npm](https://www.npmjs.com/) installed. Simply type in:

```sh
npm install # to install Riot.js and other dependencies
npm run build # to form graph.js file
```

After compilation, you will get a ```graph.js``` file which would be served through HTTPS. Then, you should include this file in all of your web pages where you want to take advantage of GraphJS functionality. 

## Getting Started

To get started with Graph.js, you need to include graph.js file (created above) to your project. Then you can initiate it with GraphJS.init function.

Example:
```html
<body>
    <script src="path/to/graph.js"></script>
    <script>
    GraphJS.init("{{YOUR-PUBLIC-ID}}", {
        host:  "{{URL-OF-GRAPHJS-INSTANCE}}",
        theme: "{{YOUR-THEME-PREFERENCE}}",
        color: "{{YOUR-COLOR-PREFERENCE}}",
        language: "{{YOUR-LANGUAGE-OF-CHOICE}}",
        defaultAvatar: "{{URL-TO-YOUR-DEFAULT-AVATAR}}"
    })
    </script>
</body>
```
The `init` function comes with multiple options:
* **host**: a URL pointing to your instance of [GraphJS-Server](https://github.com/phonetworks/graphjs-server)
* **theme**: either 'light' or 'dark'
* **color**: a string representing any color of your preference in HEX format
* **language**: current available options are en-US (English), fr-FR (French) in beta and tr-TR (Turkish). For more translations and languages, see Translations section below.
* **defaultAvatar**: either "gravatar" so all no-avatar accounts show with their [Gravatar](https://en.gravatar.com/) counterparts (if it exists) or a URL that points to your default avatar in png, gif or jpeg formats.

#### For more Information/Options/Examples, please go to [GraphJS official Documentation](https://graphjs.com/docs)

## Testing and Development

You can try your custom tags simply by editing the html files in the ```test``` directory. The files are self-explanatory, indicating what parts are to edit.

To test and develop, run ```npm run watch``` command. This command will start watching 
the library files, and the files in the test folder will be served automatically on 
your browser.

## Translations

Translation files can be found in the directory [/lib/language](https://github.com/phonetworks/graphjs/tree/master/lib/language). They are standard json files. Please make a pull request on our Github repo for us to include your contributions in the master branch.

To fetch the latest translations, run `git submodule foreach 'git pull origin master'`

## Tips & Tricks

* JS: it's the ```restart``` call which ensures that the "widget" is updated once the session status changes. See: private-content.tag for more information.
* CSS: To disable highlighting, use .disable-selection
* CSS: see the usage of .graphjs-loading and .graphjs-blocked classes in https://github.com/phonetworks/graphjs/blob/master/lib/tags/profile-followers.tag
* CSS: all tags to start with .graphjs-element. There is also .graphjs-root which is not CSS neutral.
* CSS: .graphjs-wallet for lists

## License

GNU Affero General Public License v3.0, see [LICENSE](https://github.com/phonetworks/graphjs/blob/master/LICENSE).
