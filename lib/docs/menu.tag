<docs-menu class="menu">
    <h2>Custom Tags</h2>
    <a each={item in opts.items} onclick={opts.callback} data-component={item.component} data-label={item.label}>{item.label}</a>
</docs-menu>