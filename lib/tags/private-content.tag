<graphjs-private-content class={'graphjs-element ' + (blocked ? "graphjs-root graphjs-loading" : "")}>
    <div hide={blocked} ref="privateContent"></div>
    <div if={blocked} class="graphjs-content graphjs-blocked">
        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus vitae lorem aliquet, egestas metus ac, iaculis erat. Aenean quis est placerat leo lobortis hendrerit vel ut erat. Duis ultricies pellentesque ultrices. Nam eget commodo ex. Mauris facilisis, diam id semper auctor, enim ligula placerat nibh, ac accumsan eros nisl eu nibh. Aliquam aliquam felis quis erat posuere suscipit. Vestibulum ut pharetra nulla. Donec tempus varius neque ut egestas.</p>
        <p>Phasellus pretium a neque congue facilisis. Sed lacinia nulla lacus, non gravida odio consequat at. Suspendisse aliquet pellentesque nisi, id accumsan erat auctor in. Suspendisse elementum consectetur lectus ut malesuada. Curabitur vestibulum blandit orci, sit amet efficitur nisl sollicitudin at. Nulla et fringilla neque. Mauris vel nulla justo. Integer in feugiat quam. Etiam ligula tortor, tristique at lacinia vel, pretium non urna. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Duis vitae risus posuere, condimentum sapien sit amet, pretium velit. Aliquam quam odio, molestie ac congue non, pulvinar at sem. Integer et tristique felis, vitae ornare mauris. Mauris at risus sem. Aenean id laoreet felis.</p>
        <p>Cras fringilla, nisi sit amet tincidunt cursus, erat sapien viverra leo, at pretium lectus nulla eu felis. Maecenas eros turpis, vestibulum id velit malesuada, consequat ultrices sem. Proin placerat et lectus ac vehicula. Sed commodo condimentum purus, sit amet ultricies sapien. In feugiat viverra semper. Maecenas molestie maximus nisl, ac dignissim mauris feugiat iaculis. Proin sollicitudin nibh eget convallis placerat. Nunc nec ultricies felis. Aliquam finibus, quam non eleifend suscipit, dui augue consequat orci, vitae semper nisl lectus et nulla. Nulla bibendum turpis nec scelerisque vulputate. Praesent in arcu dapibus, pellentesque nunc at, luctus tortor. Sed ornare efficitur tortor sit amet sagittis. Praesent fermentum, neque non pretium ultricies, ipsum libero commodo sem, vitae mollis arcu dui a sem. Curabitur ornare fringilla finibus.</p>
        <p>Morbi sed placerat turpis, dictum congue ipsum. Nullam vel dictum justo, ac pulvinar mauris. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras eu consectetur felis, quis consequat risus. Donec dictum consectetur arcu ac hendrerit. Nullam eros diam, mattis quis pellentesque a, tristique quis mi. Integer posuere ullamcorper diam eu iaculis. Pellentesque vel rhoncus augue, ut viverra orci. Fusce semper libero non est vestibulum sagittis. Sed rutrum purus eget porttitor tincidunt. Donec ornare vestibulum turpis, at ornare lacus accumsan eu. In eu eros sed neque condimentum malesuada et in elit. Proin sit amet lectus accumsan, fermentum sem ut, ornare leo. Mauris vel ligula porttitor, ornare ipsum in, euismod augue. Integer vestibulum gravida urna sed lacinia.</p>
        <p>Vivamus volutpat luctus velit, id blandit lacus accumsan in. Integer at ligula varius, accumsan erat et, convallis turpis. Duis tellus ante, volutpat at purus ac, vulputate interdum lacus. Nunc dignissim auctor nibh a faucibus. Suspendisse consequat sem vitae sapien scelerisque, sit amet ultrices leo finibus. Pellentesque dictum dolor rutrum est maximus cursus. Pellentesque tincidunt velit cursus justo mollis, quis egestas quam gravida. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ut leo lorem. Suspendisse in maximus augue, sit amet bibendum nisl. Aliquam erat volutpat. Quisque in maximus sapien. Nulla facilisi. Vestibulum nec quam dui.</p>
    </div>
    <button ref="blockageButton" if={blocked} onclick={handleBlock} class="graphjs-blockage">Log in to view this content</button>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/private-content.less';
    </style>
    <script>
        import getSession from '../scripts/getSession.js';
        import getPrivateContent from '../scripts/getPrivateContent.js';
        import showLogin from '../scripts/showLogin.js';

        this.blocked = true;
        this.invalid = false;

        this.on('before-mount', function() {
            this.handleSession();
        });
        this.handleBlock = (event) => {
            event.preventDefault();
            if(!this.invalid)
                showLogin({});
        };
        this.restart = () => {
            this.blocked = true;
            this.update();
            this.handleSession();
        };
        this.handleSession = () => {
            let self = this;
            getSession(function(response) {
                if(response.success) {
                    self.fetchContent();
                } else {
                    self.blocked = true;
                    self.update();
                }
            });
        };
        this.fetchContent = () => {
            let self = this;
            let content_id = opts.id;
            getPrivateContent(content_id, function(response) {
                if(response.success) {
                    //window.alert("hello "+response.contents);
                    self.refs.privateContent.innerHTML = response.contents;
                    self.blocked = false;
                    self.invalid = false;
                    self.update();
                }
                else {
                    if(response.reason&&response.reason=="Invalid ID") {
                        self.refs.blockageButton.innerText = "You can't view this content right now";
                        self.invalid = true;
                    }
                    self.blocked = true;
                    self.update();
                }
            });
        };
    </script>
</graphjs-private-content>