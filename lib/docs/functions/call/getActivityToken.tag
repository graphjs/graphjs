<docs-getActivityToken>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="type">
                <legend>Type</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="type" id="wall" checked={specs.type == 'wall'} />
                    <label for="wall">Wall</label>
                    <input onclick={updateRadio} type="radio" name="type" id="timeline" checked={specs.type == 'timeline'} />
                    <label for="timeline">Timeline</label>
                <div>
            </fieldset>
            <fieldset name="id">
                <legend>Identification</legend>
                <input onkeyup={updateText} type="text" value={specs.id} placeholder="An id is required" />
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
        import getActivityToken from '../../../scripts/getActivityToken.js';

        this.input = '';
        this.response = '';
        this.specs = {
            "type": "wall",
            "id": "48760696099368953dd71a90b727acba"
        }

        this.on('mount', function() {
            updateCallFunction(opts.function, this.specs, this.refs.inputCode);
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
            getActivityToken(
                self.specs.type,
                self.specs.id,
                function(response) {
                    self.callback(response);
                    event.target.classList.remove('loading');
                }
            );
        }
    </script>
</docs-getActivityToken>