export default function(response) {
    if(!response.success && response.reason && response.reason == "Instance inactive")
    {
		window.GraphJS.events.emit("inactive");
    }
};