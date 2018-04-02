<graphjs-profile-groups class="wallet">
    <div class="content">
        <!--
        <p if={list.length <= 0}>This does not belong to any group.</p>
        <p if={list.length > 0}>{'Member of ' + list.length + ' Group' + (list.length > 1 ? 's' : '')}</p>
        -->
        <graphjs-group-card each={id in list} id={id}></graphjs-group-card>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
    </style>
    <script>
        import listMemberships from '../scripts/listMemberships.js';

        this.id = opts.id;
        this.list = [];

        this.on('before-mount', function() {
            let self = this;
            listMemberships(self.id, function(response) {
                if(response.success) {
                    self.list = [];
                    for(let group of response.groups) {
                        self.list.push(group.id)
                    }
                    self.update();
                } else {
                    //Handle error
                }
            });
        });
    </script>
</graphjs-profile-groups>