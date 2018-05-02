<docs-showMessages>
    <h1>{opts.label}</h1>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Execute</button>
    <script>
        import updateCode from '../scripts/updateCode.js';
        import showMessages from '../../scripts/showMessages.js';

        this.input = '';
        this.specs = {}

        this.on('mount', function() {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        });
        
        this.handleCode = () => {
            updateCode('function', opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showMessages(this.specs);
        }
    </script>
</docs-showMessages>
