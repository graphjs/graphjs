<graphjs-notifications
    class={'graphjs-element graphjs-root graphjs-' + position}
    style={'font-size: calc(' + height + ' * 2 / 7);'}
>
    <graphjs-notifications-button
        minor={true}
        open={open}
        box={opts.box}
        color={opts.color}
        height={opts.height}
        target={opts.target}
        toggle={toggle}
    />
    <graphjs-notifications-list
        if={open}
        minor={true}
        title={opts.title}
        target={opts.target}
        target-profile={opts.targetProfile}
        target-feed-item={opts.targetFeedItem}
        target-messages={opts.targetMessages}
        min-width={opts.minWidth}
        max-width={opts.maxWidth}
        min-height={opts.minHeight}
        max-height={opts.maxHeight}
        toggle={toggle}
        recount={recount}
        style={
            (opts.minWidth ? 'min-width: ' + opts.minWidth + '; ' : '') +
            (opts.maxWidth ? 'max-width: ' + opts.maxWidth + '; ' : '') +
            (opts.minHeight ? 'min-height: ' + opts.minHeight + '; ' : '') +
            (opts.maxHeight ? 'max-height: ' + opts.maxHeight + '; ' : '') +
            (position == 'topleft' || position == 'topright')
                ? 'top: calc(' + height + ' + 1em);'
                : 'top: -1em'
        }
    />
    <script>
        import './notifications-button.tag';
        import './notifications-list.tag';

        this.open = false;
        this.height = opts.height || '50px';
        this.boxStyle = opts.box == 'disabled' ? 'graphjs-inline' : 'graphjs-box';
        this.position = (opts.position && ['topleft', 'topright', 'bottomleft', 'bottomright'].includes(opts.position)) ? opts.position : 'topleft';
        this.toggle = (event) => {
            this.open = !this.open;
            this.update();
        }
        this.recount = () => {
            this.tags['graphjs-notifications-button'].handleCount();
        }
    </script>
</graphjs-notifications>