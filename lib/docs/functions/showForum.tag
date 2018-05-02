<docs-showForum>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="title">
                <legend>Title</legend>
                <input onkeyup={updateText} type="text" value={specs.title} placeholder="Multiple Titles (by default)" />
            </fieldset>
            <fieldset name="access">
                <legend>Access</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="access" id="public" checked={specs.access == 'public'} />
                    <label for="public">Public</label>
                    <input onclick={updateRadio} type="radio" name="access" id="private" checked={specs.access == 'private'} />
                    <label for="private">Private</label>
                <div>
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Execute</button>
    <script>
        import updateCode from '../scripts/updateCode.js';
        import showForum from '../../scripts/showForum.js';

        this.input = '';
        this.specs = {
            "access": "public"
        }

        this.on('mount', function() {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        this.handleCode = () => {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showForum(this.specs);
        }
    </script>
</docs-showForum>
