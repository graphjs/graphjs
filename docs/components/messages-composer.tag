<docs-messages-composer>
    <h1>{opts.label}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="to">
                <legend>To</legend>
                <input onkeyup={updateText} type="text" value={specs.to} placeholder="USER ID" />
            </fieldset>
            <fieldset name="anonymity">
                <legend>Anonymity</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="anonymity" id="enabled" checked={specs.anonymity == 'enabled'} />
                    <label for="enabled">Enabled</label>
                    <input onclick={updateRadio} type="radio" name="anonymity" id="disabled" checked={specs.anonymity == 'disabled'} />
                    <label for="disabled">Disabled</label>
                <div>
            </fieldset>
            <fieldset name="placeholder">
                <legend>Placeholder</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.placeholder} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.placeholder} />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "to": "48760696099368953dd71a90b727acba",
            "anonymity": "disabled"
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
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        import {updateComponent} from '../scripts/updateCode.js';
        import updateTag from '../scripts/updateTag.js';
        this.handleCode = () => {
            updateComponent(opts.component, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        }
        this.on('mount', function() {
            updateComponent(opts.component, this.specs, this.refs.inputCode);
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        })
    </script>
</docs-messages-composer>