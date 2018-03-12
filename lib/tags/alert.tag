<graphjs-alert class="box">
    <div class="header" if={opts.title}>
        <div class="title">{opts.title}</div>
    </div>
    <div class="content">
        <p>{opts.message}</p>
    </div>
    <button if={opts.customoption == undefined || opts.customoption == ''}>Done</button>
    <button if={opts.customoption}>{opts.customoption}</button>
    <button if={opts.customoption && opts.negativeoption} class="danger">{opts.negativeoption}</button>
    <style type="less">
        @import '../styles/variables.less';
        @import '../styles/mixins.less';
        @import '../styles/options.less';
        @import '../styles/components/alert.less';
    </style>
    <script>
        this.on('mount', function() {
            let buttonList = this.root.getElementsByTagName('button');
            let buttonClass = buttonList.length > 1 ? 'half' : 'full';
            for(let i=0; i<buttonList.length; i++) {
                buttonList[i].classList.add(buttonClass);
            }
        });
    </script>
</graphjs-alert>
