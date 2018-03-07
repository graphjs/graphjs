<graphjs-state class="box">
    <div class="not-logged" if={!this.logged}>
        <a href="">Login</a>
        <a href="">Register</a>
    </div>
    <div class="logged" if={this.logged}>
        <a href="" class="details">
            <img src="lib/data/sample/user-avatar.png" />
            <span>Ozan Y.</span>
        </a>
        <a class="exit" onclick={exit}>
            <svg viewBox="0 0 20 18" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g stroke="none" stroke-width="1" fill="none" fill-rule="evenodd">
                    <g transform="translate(-17.000000, -16.000000)" fill="black" fill-rule="nonzero">
                        <path d="M19.9086651,31.0702576 L25.9789227,31.0702576 L25.9789227,34 L17,34 L17,16 L26,16 L26,18.9297424 L19.9086651,18.9297424 L19.9086651,31.0702576 Z M29.3157895,21.0187266 L31.4210526,23.0580524 L23,23.0580524 L23,25.9213483 L31.4210526,25.9213483 L29.3157895,27.9812734 L31.3789474,30 L37,24.5 L31.3789474,19 L29.3157895,21.0187266 Z"></path>
                    </g>
                </g>
            </svg>
        </a>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/state.less';
    </style>
    <script>
        import logout from '../scripts/logout.js'
        this.logged = true;
        this.root.classList.add(opts.theme || 'light');
        this.exit = () => {
            logout();
            this.logged = false;
        }
    </script>
</graphjs-state>