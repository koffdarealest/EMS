using Microsoft.AspNetCore.SignalR;

namespace EMS.Hubs
{
    public class NotificationHub : Hub
    {
        public async Task SendNotification(string user, string message)
        {
            await Clients.All.SendAsync("ReceiveMessage", user, message);
        }

        public async Task JoinGroup(string departmentId)
        {
            await Groups.AddToGroupAsync(Context.ConnectionId, departmentId);
        }

        public async Task LeaveGroup(string departmentId)
        {
            await Groups.RemoveFromGroupAsync(Context.ConnectionId, departmentId);
        }

        public async Task SendToGroup(string departmentId, string user, string message)
        {
            await Clients.Group(departmentId).SendAsync("ReceiveMessage", user, message);
        }
    }
}
