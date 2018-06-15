<docs-menu class="menu">
    <img src="docs/logo.png" />
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
    <a each={item in opts.components} class={(item.toggle ? 'toggle' : '') + (item.parent ? 'submenu' : '')} onclick={opts.callback} data-type="component" data-component={item.component} data-label={item.label} data-parent={item.parent || ''}>
        {item.label}
        <svg if={item.toggle} class="open" viewBox="0 0 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M82.6315789,0 L17.3684211,0 C7.78947368,0 0,7.78947368 0,17.3684211 L0,82.6315789 C0,92.2105263 7.78947368,100 17.3684211,100 L82.6315789,100 C92.2105263,100 100,92.2105263 100,82.6315789 L100,17.3684211 C100,7.78947368 92.2105263,0 82.6315789,0 Z M90,79.4536817 C90,85.2494062 85.2494062,90 79.4536817,90 L20.5463183,90 C14.7505938,90 10,85.2494062 10,79.4536817 L10,20.5463183 C10,14.7505938 14.7505938,10 20.5463183,10 L79.4536817,10 C85.2494062,10 90,14.7505938 90,20.5463183 L90,79.4536817 Z M30,45 L45,45 L45,30 L55,30 L55,45 L70,45 L70,55 L55,55 L55,70 L45,70 L45,55 L30,55 L30,45 Z"></path>
        </svg>
        <svg if={item.toggle} class="close" viewBox="0 0 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M82.6315789,0 L17.3684211,0 C7.78947368,0 0,7.78947368 0,17.3684211 L0,82.6315789 C0,92.2105263 7.78947368,100 17.3684211,100 L82.6315789,100 C92.2105263,100 100,92.2105263 100,82.6315789 L100,17.3684211 C100,7.78947368 92.2105263,0 82.6315789,0 Z M90,79.4536817 C90,85.2494062 85.2494062,90 79.4536817,90 L20.5463183,90 C14.7505938,90 10,85.2494062 10,79.4536817 L10,20.5463183 C10,14.7505938 14.7505938,10 20.5463183,10 L79.4536817,10 C85.2494062,10 90,14.7505938 90,20.5463183 L90,79.4536817 Z M30,45 L70,45 L70,55 L30,55 L30,45 Z"></path>
        </svg>
    </a>
    <h2>Functions</h2>
    <a each={item in opts.functions} class={(item.toggle ? 'toggle' : '') + (item.parent ? 'submenu' : '')} onclick={opts.callback} data-type="function" data-function={item.function} data-label={item.label} data-parent={item.parent || ''}>
        {item.label}
        <svg if={item.toggle} class="open" viewBox="0 0 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M82.6315789,0 L17.3684211,0 C7.78947368,0 0,7.78947368 0,17.3684211 L0,82.6315789 C0,92.2105263 7.78947368,100 17.3684211,100 L82.6315789,100 C92.2105263,100 100,92.2105263 100,82.6315789 L100,17.3684211 C100,7.78947368 92.2105263,0 82.6315789,0 Z M90,79.4536817 C90,85.2494062 85.2494062,90 79.4536817,90 L20.5463183,90 C14.7505938,90 10,85.2494062 10,79.4536817 L10,20.5463183 C10,14.7505938 14.7505938,10 20.5463183,10 L79.4536817,10 C85.2494062,10 90,14.7505938 90,20.5463183 L90,79.4536817 Z M30,45 L45,45 L45,30 L55,30 L55,45 L70,45 L70,55 L55,55 L55,70 L45,70 L45,55 L30,55 L30,45 Z"></path>
        </svg>
        <svg if={item.toggle} class="close" viewBox="0 0 100 100" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
            <path d="M82.6315789,0 L17.3684211,0 C7.78947368,0 0,7.78947368 0,17.3684211 L0,82.6315789 C0,92.2105263 7.78947368,100 17.3684211,100 L82.6315789,100 C92.2105263,100 100,92.2105263 100,82.6315789 L100,17.3684211 C100,7.78947368 92.2105263,0 82.6315789,0 Z M90,79.4536817 C90,85.2494062 85.2494062,90 79.4536817,90 L20.5463183,90 C14.7505938,90 10,85.2494062 10,79.4536817 L10,20.5463183 C10,14.7505938 14.7505938,10 20.5463183,10 L79.4536817,10 C85.2494062,10 90,14.7505938 90,20.5463183 L90,79.4536817 Z M30,45 L70,45 L70,55 L30,55 L30,45 Z"></path>
        </svg>
    </a>
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