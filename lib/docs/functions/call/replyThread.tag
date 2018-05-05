<docs-replyThread>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="to">
                <legend>Identification</legend>
                <input onkeyup={updateText} type="text" value={specs.id} placeholder="A thread id is required" />
            </fieldset>
            <fieldset name="message">
                <legend>Message</legend>
                <input onkeyup={updateText} type="text" value={specs.message} placeholder="Write a message to reply" />
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Call</button>
    <section ref="response" if={response} class="response">
        <h2>Response</h2>
        <pre class="prettyprint"><xmp ref="responseCode" class="code">{response}</xmp></pre>
    </section>
    <script>
        import {updateCallFunction} from '../../scripts/updateCode.js';
        import replyThread from '../../../scripts/replyThread.js';

        this.input = '';
        this.response = '';
        this.specs = {
            "id": "50a5a634eed9d6dad5f64daa3bef6587",
            "message": "This is a test reply."
        }

        this.on('mount', function() {
            updateCallFunction(opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.handleCode = () => {
            updateCallFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.callback = (response) => {
            this.response = JSON.stringify(response, null, 4);
            this.update();
            this.refs.responseCode.parentNode.classList.remove('prettyprinted');
            PR.prettyPrint();
            this.refs.response.scrollIntoView();
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            let self = this;
            event.target.classList.add('loading');
            self.response = false;
            replyThread(
                self.specs.id,
                self.specs.message,
                function(response) {
                    self.callback(response);
                    event.target.classList.remove('loading');
                }
            );
        }
    </script>
</docs-replyThread>