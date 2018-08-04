# GraphJS

Graph.js is a Javascript client-side library to help developers easily enable social features on their web sites. GraphJS is built upon the [Pho framework](https://github.com/phonetworks/pho-microkernel), and it's open source. With only a few lines of code, you can easily add authentication, comments, messages, forum, groups, profiles etc. to your static web pages.

## Building

Make sure you have [npm](https://www.npmjs.com/) installed. Then for development,  simply type in:

```
npm install
npm run start:development
```

For production:

```
npm run start:production
```

## Getting Started

To get started with Graph.js, you need to include graph.js file to your project. Then you can initiate it with GraphJS.init function.

Simply, add this code into your HTML, just before the end of body tag. Don't forget to replace your public ID, theme, and color options. Your public ID should be a string which can be provided by Graph.js after Setup process. Theme option should be a string, and it has to be either 'light' or 'dark'. Color option should be a string representing any color of your preference in HEX format.

```html
<script src="https://graphjs.com/graph.js"></script>
<script>
GraphJS.init("YOUR-PUBLIC-ID", {
        theme: "YOUR-THEME-PREFERENCE",
        color: "YOUR-COLOR-PREFERENCE"
})
</script>
```

## License

GNU Affero General Public License v3.0, see [LICENSE](https://github.com/phonetworks/graphjs/blob/master/LICENSE).
