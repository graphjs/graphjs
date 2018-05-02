<docs-star-list>
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
            <fieldset name="scope">
                <legend>Scope</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="scope" id="global" checked={specs.scope == 'global'} />
                    <label for="global">Global</label>
                    <input onclick={updateRadio} type="radio" name="scope" id="user" checked={specs.scope == 'user'} />
                    <label for="user">User</label>
                <div>
            </fieldset>
            <fieldset name="type">
                <legend>Type</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="type" id="default" checked={specs.type == 'default'} />
                    <label for="default">Default</label>
                    <input onclick={updateRadio} type="radio" name="type" id="like" checked={specs.type == 'like'} />
                    <label for="like">Like</label>
                    <input onclick={updateRadio} type="radio" name="type" id="love" checked={specs.type == 'love'} />
                    <label for="love">Love</label>
                    <input onclick={updateRadio} type="radio" name="type" id="save" checked={specs.type == 'save'} />
                    <label for="save">Save</label>
                <div>
            </fieldset>
            <fieldset name="min-width">
                <legend>Minimum Width</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['min-width']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['min-width']} />
            </fieldset>
            <fieldset name="max-width">
                <legend>Maximum Width</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['max-width']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['max-width']} />
            </fieldset>
            <fieldset name="min-height">
                <legend>Minimum Height</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['min-height']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['min-height']} />
            </fieldset>
            <fieldset name="max-height">
                <legend>Maximum Height</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs['max-height']} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs['max-height']} />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "type": "default",
            "scope": "global",
            "max-width": "800px"
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
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        import updateCode from '../scripts/updateCode.js';
        import updateTag from '../scripts/updateTag.js';
        this.handleCode = () => {
            updateCode('component', opts.component, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        }
        this.on('mount', function() {
            updateCode('component', opts.component, this.specs, this.refs.inputCode);
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        })
    </script>
</docs-star-list>