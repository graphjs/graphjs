<docs-showMessages>
    <h1>{opts.label}</h1>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Show</button>
    <script>
        import {updateShowFunction} from '../../scripts/updateCode.js';
        import showMessages from '../../../lib/scripts/showMessages.js';

        this.input = '';
        this.specs = {}

        this.on('mount', function() {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        });

        this.handleCode = () => {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showMessages(this.specs);
        }
    </script>
</docs-showMessages>
