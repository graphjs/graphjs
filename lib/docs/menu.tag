<docs-menu class="menu">
    <img src="lib/docs/logo.png" />
    <h2>Theme</h2>
    <form>
        <fieldset name="theme">
            <div class="radiobutton">
                <input onclick={updateRadio} type="radio" name="theme" id="light" value="light" checked={theme == 'light'} />
                <label for="light">Light</label>
                <input onclick={updateRadio} type="radio" name="theme" id="dark" value="dark" checked={theme == 'dark'} />
                <label for="dark">Dark</label>
            <div>
        </fieldset>
    </form>
    <h2>Components</h2>
    <a each={item in opts.items} onclick={opts.callback} data-component={item.component} data-label={item.label} data-parent={item.parent || ''}>{item.label}</a>
    <script>
        this.theme = 'light';
        this.updateRadio = (event) => {
            this.theme = event.target.value;
            let className = 'graphjs-theme-' + this.theme;
            document.body.classList.remove('graphjs-theme-light');
            document.body.classList.remove('graphjs-theme-dark');
            document.body.classList.add(className);
        }
        this.on('mount', function() {
            let children = document.querySelectorAll('docs-menu a[data-parent]');
            for(let child of children) {
                let parent = child.dataset.parent;
                child.classList.add(parent + '-item');
                child.classList.add('submenu');
            }
            document.querySelectorAll('docs-menu a:first-of-type')[0].click();
        });
    </script>
</docs-menu>