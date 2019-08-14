
// profile
import './tags/profile.tag';
import './tags/profile-card.tag';
import './tags/profile-header.tag';
import './tags/profile-activity.tag';
import './tags/profile-followers.tag';
import './tags/profile-following.tag';
import './tags/profile-groups.tag';
import './tags/profile-settings.tag';
import './tags/profile-list.tag';

// messages
import './tags/messages.tag';
import './tags/messages-composer.tag';

// notifications
import './tags/notifications.tag';
import './tags/notifications-button.tag';
import './tags/notifications-list.tag';

// feed
import './tags/feed.tag';
import './tags/feed-activity.tag';
import './tags/feed-composer.tag';
import './tags/feed-display.tag';
import './tags/feed-item.tag';

// members

// comments
import './tags/comments.tag';

// blog
import './tags/blog.tag';
import './tags/blog-list.tag';
import './tags/blog-post.tag';

// profile
import getProfile from './scripts/getProfile.js';
import listMemberships from './scripts/listMemberships.js';
import setAvatar from './scripts/setAvatar.js';
import setBio from './scripts/setBio.js';
import setBirthday from './scripts/setBirthday.js';
import setEmail from './scripts/setEmail.js';
import setPassword from './scripts/setPassword.js';
import setProfile from './scripts/setProfile.js';
import setUsername from './scripts/setUsername.js';
import showProfile from './scripts/showProfile.js';

// messages
import countUnreadMessages from './scripts/countUnreadMessages.js';
import getConversation from './scripts/getConversation.js';
import getConversations from './scripts/getConversations.js';
import getInbox from './scripts/getInbox.js';
import getMessage from './scripts/getMessage.js';
import getOutbox from './scripts/getOutbox.js';
import sendAnonymousMessage from './scripts/sendAnonymousMessage.js';
import sendMessage from './scripts/sendMessage.js';
import showMessages from './scripts/showMessages.js';
import showMessagesComposer from './scripts/showMessagesComposer.js';

// notifications
import getNotifications from './scripts/getNotifications.js';
import showNotificationsList from './scripts/showNotificationsList.js';

// feed
import getStatusUpdates from './scripts/getStatusUpdates.js';
import getStatusUpdate from './scripts/getStatusUpdate.js';
import updateStatus from './scripts/updateStatus.js';
import removeStatusUpdate from './scripts/removeStatusUpdate.js';
import showFeedItem from './scripts/showFeedItem.js';

// members
import follow from './scripts/follow.js';
import getFollowers from './scripts/getFollowers.js';
import getFollowing from './scripts/getFollowing.js';
import getMembers from './scripts/getMembers.js';
import unfollow from './scripts/unfollow.js';

// comments
import addComment from './scripts/addComment.js';
import getComments from './scripts/getComments.js';
import removeComment from './scripts/removeComment.js';
import showComments from './scripts/showComments.js';

// blog
import commentBlogPost from './scripts/commentBlogPost.js';
import editBlogPost from './scripts/editBlogPost.js';
import editBlogComment from './scripts/editBlogComment.js';
import getBlogComments from './scripts/getBlogComments.js';
import getBlogPost from './scripts/getBlogPost.js';
import getBlogPosts from './scripts/getBlogPosts.js';
import removeBlogPost from './scripts/removeBlogPost.js';
import removeBlogComment from './scripts/removeBlogComment.js';
import startBlogPost from './scripts/startBlogPost.js';
import unpublishBlogPost from './scripts/unpublishBlogPost.js';
import showBlog from './scripts/showBlog.js';
import showBlogComposer from './scripts/showBlogComposer.js';
import showBlogList from './scripts/showBlogList.js';
import showBlogPost from './scripts/showBlogPost.js';

export default {
    // profile
    getProfile, listMemberships, setAvatar, setBio, setBirthday, setEmail, setPassword, setProfile, setUsername, showProfile, 
    // messages
    countUnreadMessages, getConversation, getConversations, getInbox, getMessage, getOutbox, sendAnonymousMessage, sendMessage, showMessages, showMessagesComposer, 
    // notifications
    getNotifications, showNotificationsList, 
    // feed
    getStatusUpdates, getStatusUpdate, updateStatus, removeStatusUpdate, showFeedItem, 
    // members
    follow, getFollowers, getFollowing, getMembers, unfollow, 
    // comments
    addComment, getComments, removeComment, showComments, 
    // blog
    commentBlogPost, editBlogPost, editBlogComment, getBlogComments, getBlogPost, getBlogPosts, removeBlogPost, removeBlogComment, startBlogPost, unpublishBlogPost, showBlog, showBlogComposer, showBlogList, showBlogPost, 
}