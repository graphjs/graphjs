<docs-alert>
    <h1>{opts.label}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <h2>Options</h2>
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
            <fieldset name="custom-option">
                <legend>Custom Option</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['custom-option']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['custom-option']} placeholder="Done" />
            </fieldset>
            <fieldset name="negative-option">
                <legend>Negative Option</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['negative-option']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['negative-option']} />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "title": "Login Required",
            "message": "You need to login to view the group details.",
            "custom-option": "Login",
            "negative-option": "Cancel"
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
