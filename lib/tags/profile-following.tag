<graphjs-profile-following class="wallet">
    <div class="content">
        <p if={list.length <= 0}>This user is not following any users.</p>
        <p if={list.length > 0}>{'Following ' + list.length + ' User' + (list.length > 1 ? 's' : '')}</p>
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import getFollowing from '../scripts/getFollowing.js';

        this.id = opts.id;
        this.list = [];

        this.on('before-mount', function() {
            let self = this;
            getFollowing(self.id, function(response) {
                if(response.success) {
                    self.list = Object.keys(response.following);
                    self.update();
                } else {
                    //Handle error
                }
            });
        });
    </script>
</graphjs-profile-following>