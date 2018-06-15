<docs-showAuth>
    <h1>{opts.label}</h1>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="default">
                <legend>Default</legend>
                <input onclick={updateRadioWithCheckbox} type="checkbox" checked={specs.default} />
                <div class="radiobutton">
                    <input onclick={updateRadioWithCheckbox} type="radio" name="default" id="login" checked={specs.default == 'login'} />
                    <label for="login">Login</label>
                    <input onclick={updateRadioWithCheckbox} type="radio" name="default" id="register" checked={specs.default == 'register'} />
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
        import showAuth from '../../../lib/scripts/showAuth.js';

        this.input = '';
        this.specs = {}

        this.on('mount', function() {
            updateShowFunction(opts.function, this.specs, this.refs.inputCode);
        });

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
            showAuth(this.specs);
        }
    </script>
</docs-showAuth>
