<graphjs-comments class="box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title || 'Comments'}</div>
    </div>
    <div class="content">
        <div class="synopsis">
            243 views
            &middot;
            3 replies
            <button>Write a reply</button>
        </div>
        <div class="item">
            <div class="credit">
                <img src="lib/data/sample/user-avatar.png" />
                <span>
                    Ozan İlbey Yılmaz
                    <br />
                    <time>4 hours ago</time>
                </span>
            </div>
            <p>If you remember to apply at least one or two and ideally all 3 of these golden graphic design rules there’s no reason why you shouldn’t be a millionaire/billionaire within one or two months. Now get creative!</p>
        </div>
        <div class="item">
            <div class="credit">
                <img src="lib/data/sample/user-avatar.png" />
                <span>
                    Ozan İlbey Yılmaz
                    <br />
                    <time>4 hours ago</time>
                </span>
            </div>
            <p>If you remember to apply at least one or two and ideally all 3 of these golden graphic design rules there’s no reason why you shouldn’t be a millionaire/billionaire within one or two months. Now get creative!</p>
        </div>
        <div class="item">
            <div class="credit">
                <img src="lib/data/sample/user-avatar.png" />
                <span>
                    Ozan İlbey Yılmaz
                    <br />
                    <time>4 hours ago</time>
                </span>
            </div>
            <p>If you remember to apply at least one or two and ideally all 3 of these golden graphic design rules there’s no reason why you shouldn’t be a millionaire/billionaire within one or two months. Now get creative!</p>
        </div>
        <div class="reply">
            <textarea placeholder="Write your reply here..."></textarea>
            <button>Send Reply</button>
            <button class="danger">Clear</button>
        </div>
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/comments.less';
    </style>
</graphjs-comments>