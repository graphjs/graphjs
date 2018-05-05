<docs-showAlert>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="title">
                <legend>Title</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.title} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.title} />
            </fieldset>
            <fieldset name="message">
                <legend>Message</legend>
                <input onkeyup={updateText} type="text" value={specs.message} placeholder="A message is required." />
            </fieldset>
            <fieldset name="affirmative">
                <legend>Affirmative</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.affirmative} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.affirmative} placeholder="Done" />
            </fieldset>
            <fieldset name="negative">
                <legend>Negative</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.negative} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.negative} />
            </fieldset>
            <fieldset name="show">
                <legend>Show</legend>
                <input onclick={updateRadioWithCheckbox} type="checkbox" checked={specs.show} />
                <div class="radiobutton">
                    <input onclick={updateRadioWithCheckbox} type="radio" name="show" id="login" checked={specs.show == 'login'} />
                    <label for="login">Login</label>
                    <input onclick={updateRadioWithCheckbox} type="radio" name="show" id="register" checked={specs.show == 'register'} />
                    <label for="register">Register</label>
                <div>
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Show</button>
    <script>
        import {updateShowFunction} from '../../scripts/updateCode.js';
        import showAlert from '../../../scripts/showAlert.js';

        this.input = '';
        this.specs = {
            "title": "Login Required",
            "message": "You need to login to view the group details.",
            "affirmative": "Login",
            "negative": "Cancel",
            "show": "login"
        }

        this.on('mount', function() {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        });

        this.updateText = (event) => {
            let target = event.target.parentNode.name;
            this.specs[target] = event.target.value;
            this.handleCode();
        }
        this.updateTextWithCheckbox = (event) => {
            let target = event.target.parentNode.name;
            if(event.target.type == 'checkbox') {
                let sibling = event.target.parentNode.children[2];
                event.target.checked ? this.specs[target] = sibling.value : delete this.specs[target];
            } else {
                let sibling = event.target.parentNode.children[1];
                this.specs[target] = event.target.value;
            }
            this.handleCode();
        }
        this.updateRadioWithCheckbox = (event) => {
            let target;
            if(event.target.type == 'checkbox') {
                target = event.target.parentNode.name;
                let sibling = event.target.parentNode.children[2];
                let actor = sibling.firstElementChild;
                for(let item of sibling.children) {
                    if(item.checked) {
                        actor = item;
                    }
                }
                if(event.target.checked) {
                    actor.click();
                } else {
                    delete this.specs[target];
                }
            } else {
                target = event.target.parentNode.parentNode.name;
                let sibling = event.target.parentNode.parentNode.children[1];
                this.specs[target] = event.target.id;
            }
            this.handleCode();
        }
        this.handleCode = () => {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            showAlert(this.specs);
        }
    </script>
</docs-showAlert>
