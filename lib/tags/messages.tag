<graphjs-messages class="box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Messages'}</div>
    </div>
    <div class="content">
        <div class="sidebar">
            <a class="active item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="unread item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="unread item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
            <a class="item">
                <img src="lib/data/sample/user-avatar.png" />
                <div>
                    <b>Ozan İlbey Yılmaz</b>
                    If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.
                </div>
            </a>
        </div>
        <div class="main">
            <div class="conversation">
                <div class="inbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="outbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <div>
                        <p>It's a living hell.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="inbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <div>
                        <p>It's a living hell.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
                <div class="outbound item">
                    <div>
                        <p>If you live in New York City or travel to and from New York City a lot, you know all about the traffic there.</p>
                    </div>
                    <time>2 minutes ago</time>
                </div>
            </div>
            <textarea placeholder="Write your message here..."></textarea>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/messages.less';
    </style>
    <script>
        import getInbox from '../scripts/getInbox.js';
        /*
        this.on('mount', function() {
            fetch(getInbox())
            .then(response => {
                if (response.success) {
                    console.log('success');
                } else {
                    console.log('fail')
                }
            })
        });
        */
    </script>
</graphjs-messages>