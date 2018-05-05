<docs-showForumComposer>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="title">
                <legend>Title</legend>
                <input onkeyup={updateText} type="text" value={specs.title} placeholder="New Thread" />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Show</button>
    <script>
        import {updateShowFunction} from '../../scripts/updateCode.js';
        import showForumComposer from '../../../scripts/showForumComposer.js';

        this.input = '';
        this.specs = {}

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
            showForumComposer(this.specs);
        }
    </script>
</docs-showForumComposer>
