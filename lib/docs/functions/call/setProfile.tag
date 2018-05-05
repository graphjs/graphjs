<docs-setProfile>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="avatar">
                <legend>Avatar</legend>
                <input onkeyup={updateText} type="text" value={specs.avatar} placeholder="A valid image URL is required" />
            </fieldset>
            <fieldset name="birthday">
                <legend>Birthday</legend>
                <input onkeyup={updateText} type="text" value={specs.birthday} placeholder="A date (MM/DD/YYYY) is required" />
            </fieldset>
            <fieldset name="about">
                <legend>Short Bio</legend>
                <input onkeyup={updateText} type="text" value={specs.about} placeholder="A short bio text is required" />
            </fieldset>
            <fieldset name="username">
                <legend>Username</legend>
                <input onkeyup={updateText} type="text" value={specs.username} placeholder="A valid username is required" />
            </fieldset>
            <fieldset name="email">
                <legend>Email</legend>
                <input onkeyup={updateText} type="text" value={specs.email} placeholder="A valid email is required" />
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
        import setProfile from '../../../scripts/setProfile.js';

        this.input = '';
        this.response = '';
        this.specs = {
            "avatar": "",
            "birthday": "",
            "about": "",
            "username": "",
            "email": ""
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
            setProfile(
                self.specs.avatar,
                self.specs.birthday,
                self.specs.about,
                self.specs.username,
                self.specs.email,
                function(response) {
                    self.callback(response);
                    event.target.classList.remove('loading');
                }
            );
        }
    </script>
</docs-setProfile>