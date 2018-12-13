<graphjs-overlay class={'graphjs-element graphjs-root' + (opts.scroll ? ' graphjs-scroll' : '')} onclick={handleExit} if={overlayActive}>
    <div ref="container"></div>
    <script>
        // Create tag
        let tag = document.createElement(opts.component);
        delete opts.component;
        // Set tag properties
        for(let key of Object.keys(opts)) {
            let attribute = document.createAttribute(key);
            attribute.value = opts[key];
            tag.setAttributeNode(attribute);
        }
        tag.onclick = function(event) {
            event.stopPropagation();
        }
        this.overlayActive = true;
        this.handleExit = (event) => {
            this.unmount();
        }
        // Mount & append tag on mount
        this.on('mount', function() {
            riot.mount(tag);
            this.refs.container.appendChild(tag);
            document.body.style.overflow = 'hidden';
        });
        this.on('unmount', function() {
            document.body.style.overflow = 'auto';
        });
    </script>
</graphjs-overlay>