<graphjs-alert class="graphjs-root box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title}</div>
    </div>
    <div class="content">
        <p>{opts.message}</p>
    </div>
    <button if={opts.affirmative == undefined || opts.affirmative == ''} onclick={handleButton}>Done</button>
    <button ref="custom" if={opts.affirmative} onclick={handleButton}>{opts.affirmative}</button>
    <button if={opts.affirmative && opts.negative} onclick={handleButton} class="danger">{opts.negative}</button>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/alert.less';
    </style>
    <script>
        import hideOverlay from '../scripts/hideOverlay.js';
        import showAuth from '../scripts/showAuth.js';
        import showLogin from '../scripts/showLogin.js';
        import showRegister from '../scripts/showRegister.js';
        import showReset from '../scripts/showReset.js';
        import showComments from '../scripts/showComments.js';
        import showForum from '../scripts/showForum.js';
        import showMessages from '../scripts/showMessages.js';
        this.showFunctions = {
            auth: showAuth,
            login: showLogin,
            register: showRegister,
            reset: showReset,
            comments: showComments,
            forum: showForum,
            message: showMessages
        }
        this.handleButton = (event) => {
            if(event.target.hasAttribute('to')) {
                //Needs improvement
                window.location.href = window.location.href + opts.to;
            } else if(event.target.hasAttribute('show')) {
                this.showFunctions.hasOwnProperty(opts.show) ? this.showFunctions[opts.show]() : hideOverlay();
            } else {
                hideOverlay();
            }
        }
        this.on('mount', function() {
            let buttonList = this.root.getElementsByTagName('button');
            let buttonClass = buttonList.length > 1 ? 'half' : 'full';
            for(let i=0; i<buttonList.length; i++) {
                buttonList[i].classList.add(buttonClass);
            }
            opts.show && this.refs.custom.setAttribute('show', opts.show);
            opts.to && this.refs.custom.setAttribute('to', opts.to);
        });
    </script>
</graphjs-alert>
