<docs-list>
    <h1>{opts.label}</h1>
    <h2><{opts.component}></h2>
    <section class="demo" ref="liveDemo"></section>
    <h2>Options</h2>
    <section class="options">
        <form>
            <fieldset name="content">
                <legend>Content</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="content" id="users" checked={specs.content == 'users'} />
                    <label for="users">Users</label>
                    <input onclick={updateRadio} type="radio" name="content" id="groups" checked={specs.content == 'groups'} />
                    <label for="groups">Groups</label>
                <div>
            </fieldset>
            <fieldset name="access">
                <legend>Access</legend>
                <div class="radiobutton">
                    <input onclick={updateRadio} type="radio" name="access" id="public" checked={specs.access == 'public'} />
                    <label for="public">Public</label>
                    <input onclick={updateRadio} type="radio" name="access" id="private" checked={specs.access == 'private'} />
                    <label for="private">Private</label>
                <div>
            </fieldset>
        </form>
    </section>
    <h2>Code</h2>
    <pre class="prettyprint"><xmp ref="inputCode" class="code">{input}</xmp></pre>
    <button onclick={handleSubmit}>Apply</button>
    <script>
        this.input = '';
        this.specs = {
            "content": "users",
            "access": "public"
        }
        this.updateRadio = (event) => {
            let target = event.target.parentNode.parentNode.name;
            this.specs[target] = event.target.id;
            this.handleCode();
        }
        import {updateComponent} from '../scripts/updateCode.js';
        import updateTag from '../scripts/updateTag.js';
        this.handleCode = () => {
            updateComponent(opts.component, this.specs, this.refs.inputCode);
        }
        this.handleSubmit = (event) => {
            event.preventDefault();
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        }
        this.on('mount', function() {
            updateComponent(opts.component, this.specs, this.refs.inputCode);
            updateTag(opts.component, this.specs, this.refs.liveDemo);
        })
    </script>
</docs-list>