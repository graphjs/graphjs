<docs-alert>
    <h1>{opts.title}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <section class="options">
        <form>
            <fieldset name="title">
                <legend>Title</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.title} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.title} />
            </fieldset>
            <fieldset name="message">
                <legend>Message</legend>
                <input onkeyup={updateText} type="text" value={specs.message} placeholder="A message is required." />
            </fieldset>
            <fieldset name="customoption">
                <legend>Custom Option</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.customoption} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.customoption} placeholder="Done" />
            </fieldset>
            <fieldset name="negativeoption">
                <legend>Negative Option</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.negativeoption} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.negativeoption} />
            </fieldset>
            <fieldset name="theme">
                <legend>Theme</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="theme" id="light" checked={specs.theme == 'light'} />
                    <label for="light">Light</label>
                    <input onclick={updateRadio} type="radio" name="theme" id="dark" checked={specs.theme == 'dark'} />
                    <label for="dark">Dark</label>
                <div>
            </fieldset>
            <xmp ref="inputCode" onclick={handleCode} class="code">{input}</xmp>
            <button onclick={handleSubmit}>Apply</button>
        </form>
    </section>
    <script>
        this.input = '';
        this.specs = {
            "title": "Login Required",
            "message": "You need to login to view the group details.",
            "customoption": "Login",
            "negativeoption": "Cancel",
            "theme": "light"
        }
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.updateTextWithCheckbox = (event) => {
            let target = event.target.parentNode.name;
            if(event.target.type == 'checkbox') {
                let sibling = event.target.parentNode.children[2];
                event.target.checked ? this.specs[target] = sibling.value : delete this.specs[target];
            } else {
                let sibling = event.target.parentNode.children[1];
                this.specs[target] = event.target.value;
            }
            this.handleCode();
        }
        import updateCode from '../scripts/updateCode.js';
        import updateTag from '../scripts/updateTag.js';
        this.handleCode = () => {
            updateCode(opts.component, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        }
        this.on('mount', function() {
            updateCode(opts.component, this.specs, this.refs.inputCode);
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        })
    </script>
</docs-alert>
