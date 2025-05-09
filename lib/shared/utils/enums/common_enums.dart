enum TripStatus {
  all,
  assigned,
  completed,
  cancelled,
}

extension TripStatusExtension on TripStatus? {
  String get toValue {
    switch (this) {
      case TripStatus.all:
        return 'all';

      case TripStatus.assigned:
        return 'assigned';

      case TripStatus.completed:
        return 'completed';
      case TripStatus.cancelled:
        return 'cancelled';

      case null:
        return 'all';
    }
  }

  String get toName {
    switch (this) {
      case TripStatus.all:
        return 'All';

      case TripStatus.assigned:
        return 'Assigned';

      case TripStatus.completed:
        return 'Completed';
      case TripStatus.cancelled:
        return 'Cancelled';
      case null:
        return 'All';
    }
  }

  List<TripStatus> get getAll {
    return [
      TripStatus.all,
      TripStatus.assigned,
      TripStatus.completed,
      TripStatus.cancelled,
    ];
  }
}
