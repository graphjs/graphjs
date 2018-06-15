<docs-register>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="username">
                <legend>Username</legend>
                <input onkeyup={updateText} type="text" value={specs.username} placeholder="A valid username is required" />
            </fieldset>
            <fieldset name="email">
                <legend>Email</legend>
                <input onkeyup={updateText} type="text" value={specs.email} placeholder="A valid email is required" />
            </fieldset>
            <fieldset name="password">
                <legend>Password</legend>
                <input onkeyup={updateText} type="text" value={specs.password} placeholder="A password is required" />
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
        import register from '../../../lib/scripts/register.js';

        this.input = '';
        this.response = '';
        this.specs = {
            "username": "",
            "email": "",
            "password": ""
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
            register(
                self.specs.username,
                self.specs.email,
                self.specs.password,
                function(response) {
                    self.callback(response);
                    event.target.classList.remove('loading');
                }
            );
        }
    </script>
</docs-register>