<graphjs-forum
    class="graphjs-element graphjs-root graphjs-box"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <graphjs-forum-list
        minor={true}
        title={opts.title}
        access={opts.access}
        callback={changeProperties}
        if={this.active == 'list'}
    />
    <graphjs-forum-thread
        minor={true}
        title={opts.title}
        access={opts.access}
        id={id}
        callback={changeProperties}
        if={this.active == 'thread'}
    />
    <graphjs-forum-composer
        minor={true}
        title={opts.title}
        callback={changeProperties}
        if={this.active == 'compose'}
    />
    <script>
        import './forum-list.tag'
        import './forum-thread.tag'
        import './forum-composer.tag'

        this.active = opts.default || 'list';
        this.id = opts.id;
        this.changeProperties = (properties) => {
            this.active = properties.link || undefined;
            this.id = properties.id || undefined;
            this.update();
        }
    </script>
</graphjs-forum>