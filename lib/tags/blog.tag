<graphjs-blog
    class={'graphjs-element graphjs-root ' + boxStyle}
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <graphjs-blog-list
        minor={true}
        title={opts.title}
        box="disabled"
        callback={changeProperties}
        if={this.active == 'list'}
    />
    <graphjs-blog-post
        minor={true}
        title={opts.title}
        id={id}
        box="disabled"
        callback={changeProperties}
        if={this.active == 'post'}
    />
    <graphjs-blog-composer
        minor={true}
        title={opts.title}
        id={id}
        box="disabled"
        callback={changeProperties}
        if={this.active == 'composer'}
    />
    <script>
        import './blog-list.tag';
        import './blog-post.tag';
        import './blog-composer.tag';

        this.active = opts.default || 'list';
        this.id = opts.id;
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';

        let self = this;

        this.on('mount', function() {
            window.addEventListener('popstate', function() {
                let hash = window.location.hash;
                if(hash) {
                    let parts = hash.split('-');
                    if(parts.length > 2) {
                        if(parts[parts.length - 1] === 'GJS') {
                            self.changeProperties({
                                link: 'post',
                                id: parts[parts.length - 2]
                            });
                        }
                    }
                }
            });
        });

        this.changeProperties = (properties) => {
            this.active = properties.link || undefined;
            this.id = properties.id || undefined;
            this.update();
        }
    </script>
</graphjs-blog>