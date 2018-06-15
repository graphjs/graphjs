<docs-star-button>
    <h1>{opts.label}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="type">
                <legend>Default</legend>
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
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "type": "default"
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
</docs-star-button>