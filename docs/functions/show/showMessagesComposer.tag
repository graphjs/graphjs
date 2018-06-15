<docs-showMessagesComposer>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="to">
                <legend>To</legend>
                <input onkeyup={updateText} type="text" value={specs.to} placeholder="USER ID" />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Show</button>
    <script>
        import {updateShowFunction} from '../../scripts/updateCode.js';
        import showMessagesComposer from '../../../lib/scripts/showMessagesComposer.js';

        this.input = '';
        this.specs = {
            "to": "48760696099368953dd71a90b727acba"
        }

        this.on('mount', function() {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.handleCode = () => {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showMessagesComposer(this.specs);
        }
    </script>
</docs-showMessagesComposer>
