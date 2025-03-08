namespace EMS.Models.Attendance
{
    public class CheckInRequestModel
    {
        public long UserId { get; set; }
        public bool IsCheckOut { get; set; }
        public string ImageData { get; set; }
    }
}
