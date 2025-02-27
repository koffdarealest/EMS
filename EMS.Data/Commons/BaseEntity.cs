namespace EMS.Data.Commons
{
    public abstract class BaseEntity<T> : IEntity<T>
    {
        public required T Id { get; set; }
        public bool IsDeleted { get; set; }
        public DateTime CreatedAt { get; set; }
        public DateTime? UpdatedAt { get; set; }
        public DateTime? DeletedAt { get; set; }
        public long CreatedBy { get; set; }
        public long UpdatedBy { get; set; }
        public long DeletedBy { get; set; }
    }
}
