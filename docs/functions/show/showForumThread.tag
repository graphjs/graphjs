<docs-showForumThread>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="id">
                <legend>Identification</legend>
                <input onkeyup={updateText} type="text" value={specs.id} placeholder="Identification number is required" />
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
    <button onclick={handleSubmit}>Show</button>
    <script>
        import {updateShowFunction} from '../../scripts/updateCode.js';
        import showForumThread from '../../../lib/scripts/showForumThread.js';

        this.input = '';
        this.specs = {
            "id": "50a5a634eed9d6dad5f64daa3bef6587",
            "access": "public"
        }

        this.on('mount', function() {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
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
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showForumThread(this.specs);
        }
    </script>
</docs-showForumThread>
