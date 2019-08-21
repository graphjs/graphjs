<graphjs-feed
    class="graphjs-element graphjs-root"
    style={
        (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
        (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
        (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
        (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '')
    }
>
    <graphjs-feed-composer
        minor={true}
        box={opts.box}
        push={pushNewItem}
    />
    <graphjs-feed-activity
        minor={true}
        box={opts.box}
        offset={opts.offset}
        count={opts.count}
        item-link-template={opts.itemLinkTemplate}
    />
    <script>
        import './feed-composer.tag';
        import './feed-activity.tag';

        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.pushNewItem = (id) => {
            this.tags['graphjs-feed-activity'].handleNewContent(id);
        }
    </script>
</graphjs-feed>