<graphjs-group-members class="wallet">
    <div class="content">
        <graphjs-profile-card each={id in list} id={id}></graphjs-profile-card>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import listMembers from '../scripts/listMembers.js';

        this.id = opts.id;
        this.list = [];

        this.on('before-mount', function() {
            let self = this;
            listMembers(self.id, function(response) {
                if(response.success) {
                    self.list = response.members;
                    self.update();
                } else {
                    //Handle error
                }
            });
        });
    </script>
</graphjs-group-members>