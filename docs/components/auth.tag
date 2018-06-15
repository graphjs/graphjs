<docs-auth>
    <h1>{opts.label}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="type">
                <legend>Type</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="type" id="standalone" checked={specs.type == 'standalone'} />
                    <label for="standalone">Standalone</label>
                    <input onclick={updateRadio} type="radio" name="type" id="inline" checked={specs.type == 'inline'} />
                    <label for="inline">Inline</label>
                <div>
            </fieldset>
            <fieldset name="theme">
                <legend>Theme</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="theme" id="default" checked={specs.theme == 'default'} />
                    <label for="default">Default</label>
                    <input onclick={updateRadio} type="radio" name="theme" id="color" checked={specs.theme == 'color'} />
                    <label for="color">Color</label>
                <div>
            </fieldset>
            <fieldset name="position">
                <legend>Position</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="position" id="topleft" checked={specs.position == 'topleft'} />
                    <label for="topleft">T.Left</label>
                    <input onclick={updateRadio} type="radio" name="position" id="topright" checked={specs.position == 'topright'} />
                    <label for="topright">T.Right</label>
                    <input onclick={updateRadio} type="radio" name="position" id="bottomleft" checked={specs.position == 'bottomleft'} />
                    <label for="bottomleft">B.Left</label>
                    <input onclick={updateRadio} type="radio" name="position" id="bottomright" checked={specs.position == 'bottomright'} />
                    <label for="bottomright">B.Right</label>
                <div>
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "type": "standalone",
            "theme": "default",
            "position": "topleft"
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
</docs-auth>