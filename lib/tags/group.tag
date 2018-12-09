<graphjs-group class="graphjs-element graphjs-root">
    <graphjs-group-header
        id={opts.id}
        active={active}
        minor={true}
        box={opts.box}
        callback={changeProperties}
    />
    <graphjs-group-activity
        id={opts.id}
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'activity'}
    />
    <graphjs-group-members
        id={opts.id}
        minor={true}
        callback={changeProperties}
        if={active == 'members'}
    />
    <graphjs-group-settings
        id={opts.id}
        minor={true}
        box={opts.box}
        callback={changeProperties}
        if={active == 'settings'}
    />
    <script>
        import analytics from '../scripts/analytics.js';
        import './group-header.tag';
        import './group-activity.tag';
        import './group-members.tag';
        import './group-settings.tag';

        analytics("group");

        this.active = opts.default || 'members';
        this.changeProperties = (event) => {
            this.active = event.currentTarget.dataset.link;
            this.update();
        }
    </script>
</graphjs-group>