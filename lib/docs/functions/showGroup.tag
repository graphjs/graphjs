<docs-showGroup>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="id">
                <legend>Identification</legend>
                <input onkeyup={updateText} type="text" value={specs.id} placeholder="GROUP ID" />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Execute</button>
    <script>
        import updateCode from '../scripts/updateCode.js';
        import showGroup from '../../scripts/showGroup.js';

        this.input = '';
        this.specs = {
            "id": "33365d758357b6e724c360272ebf8895"
        }

        this.on('mount', function() {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.handleCode = () => {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showGroup(this.specs);
        }
    </script>
</docs-showGroup>
