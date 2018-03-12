<graphjs-forum-thread class={opts.minor != true && 'box'}>
    <div class="header">
        <a class="option left" data-link="list" onclick={opts.minor ? opts.callback : ''}>
            <svg fill="blue" viewBox="0 0 30 30" version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink">
                <g transform="translate(-15.000000, -15.000000)" fill="black" fill-rule="nonzero">
                    <path d="M29.9834254,15 C38.2707182,15 45,21.6961326 45,29.9834254 C45,38.2707182 38.2707182,45 29.9834254,45 C21.6961326,45 15,38.2707182 15,29.9834254 C15,21.6961326 21.6961326,15 29.9834254,15 Z M29.9834254,42.3480663 C36.7790055,42.3480663 42.3480663,36.8121547 42.3480663,29.9834254 C42.3480663,23.1878453 36.8121547,17.6187845 29.9834254,17.6187845 C23.1878453,17.6187845 17.6187845,23.1546961 17.6187845,29.9834254 C17.6519337,36.7790055 23.1878453,42.3480663 29.9834254,42.3480663 Z M25.4088398,29.9834254 L31.6077348,36.1823204 L33.4972376,34.2928177 L29.1546961,29.9834254 L33.4972376,25.640884 L31.6077348,23.7513812 L25.4088398,29.9834254 Z"></path>
                </g>
            </svg>
        </a>
        <div class="title">{opts.title || 'Thread by Ozan İlbey Yılmaz'}</div>
    </div>
    <div class="content">
        <div class="entry">
            <div class="credit">
                <img src="lib/data/sample/user-avatar.png" />
                <span>
                    Ozan İlbey Yılmaz
                    <br />
                    <time>February 10, 2018 8:05AM</time>
                </span>
            </div>
            <article>
                <h1>Strict graphic design rules to remember</h1>
                <p>Ever wondered how some graphic designers always manage to produce beautiful looking designs for their brochures, website designs, logo designs? Talent…yes, it helps but there are a handful of more important things you can do that will have even complete beginners producing award winning design.</p>
                <p>There are some that graphic designers will insist are to be obeyed. Only use limited fonts on a design or never use green on a magazine or book cover. Nonsense. You can pretty much do whatever you like but you must apply these STRICT GRAPHIC DESIGN RULES and you will soon be walking away with graphic design silverware.</p>
            </article>
        </div>
        <div class="replies">
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
    </div>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/forum-thread.less';
    </style>
</graphjs-forum-thread>