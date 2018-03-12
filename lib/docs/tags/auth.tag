<docs-auth>
    <h1>{opts.title}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <section class="options">
        <form>
            <fieldset name="title">
                <legend>Title</legend>
                <input onclick={updateTextWithCheckbox} type="checkbox" checked={specs.title} />
                <input onkeyup={updateTextWithCheckbox} type="text" value={specs.title} />
            </fieldset>
            <fieldset name="default">
                <legend>Default</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="default" id="register" checked={specs.default == 'register'} />
                    <label for="register">Register</label>
                    <input onclick={updateRadio} type="radio" name="default" id="login" checked={specs.default == 'login'} />
                    <label for="login">Login</label>
                    <input onclick={updateRadio} type="radio" name="default" id="reset" checked={specs.default == 'reset'} />
                    <label for="reset">Reset</label>
                <div>
            </fieldset>
            <fieldset name="theme">
                <legend>Theme</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="theme" id="light" checked={specs.theme == 'light'} />
                    <label for="light">Light</label>
                    <input onclick={updateRadio} type="radio" name="theme" id="dark" checked={specs.theme == 'dark'} />
                    <label for="dark">Dark</label>
                    <input onclick={updateRadio} type="radio" name="theme" id="color" checked={specs.theme == 'color'} />
                    <label for="color">Color</label>
                <div>
            </fieldset>
            <xmp ref="inputCode" onclick={handleCode} class="code">{input}</xmp>
            <button onclick={handleSubmit}>Apply</button>
        </form>
    </section>
    <script>
        this.input = '';
        this.specs = {
            "default": "register",
            "theme": "light"
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
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        import updateCode from '../scripts/updateCode.js';
        import updateTag from '../scripts/updateTag.js';
        this.handleCode = () => {
            updateCode(opts.component, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        }
        this.on('mount', function() {
            updateCode(opts.component, this.specs, this.refs.inputCode);
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        })
    </script>
</docs-auth>