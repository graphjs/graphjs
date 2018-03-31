<graphjs-profile-followers class="wallet">
    <div class="content">
        <p if={list.length <= 0}>This user has no followers.</p>
        <p if={list.length > 0}>{list.length + ' Follower' + (list.length > 1 ? 's' : '')}</p>
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import getFollowers from '../scripts/getFollowers.js';

        this.id = opts.id;
        this.list = [];

        this.on('before-mount', function() {
            let self = this;
            getFollowers(self.id, function(response) {
                if(response.success) {
                    self.list = Object.keys(response.followers);
                    self.update();
                } else {
                    //Handle error
                }
            });
        });
    </script>
</graphjs-profile-followers>