# GraphJS

Graph.js is a Javascript client-side library to help developers easily enable social features on their web sites. GraphJS is built upon the [Pho framework](https://github.com/phonetworks/pho-microkernel), and it's open source. With only a few lines of code, you can easily add authentication, comments, messages, forum, groups, profiles etc. to your static web pages.

## Building

Make sure you have [npm](https://www.npmjs.com/) installed. Simply type in:

```
npm install
npm run build
```

After compilation, you will get a ```graph.js``` file which would be served through HTTPS. Then, you should include this file in all of your web pages where you want to take advantage of GraphJS functionality. 

## Getting Started

To get started with Graph.js, you need to include graph.js file (created above) to your project. Then you can initiate it with GraphJS.init function.

The ```init``` function comes with three options:
* **host**: a URL pointing to your instance of [GraphJS-Server](https://github.com/phonetworks/graphjs-server)
* **theme**: either 'light' or 'dark'
* **color**: a string representing any color of your preference in HEX format

Example:
```html
<script>
GraphJS.init("{{YOUR-PUBLIC-ID}}", {
        host:  "{{URL-OF-GRAPHJS-INSTANCE}}",
        theme: "{{YOUR-THEME-PREFERENCE}}",
        color: "{{YOUR-COLOR-PREFERENCE}}"
})
</script>
```

## Tips & Tricks

* CSS: To disable highlighting, use .disable-selection

## License

GNU Affero General Public License v3.0, see [LICENSE](https://github.com/phonetworks/graphjs/blob/master/LICENSE).
