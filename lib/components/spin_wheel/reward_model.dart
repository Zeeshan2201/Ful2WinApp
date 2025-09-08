class RewardSegment {
  final String label;   // e.g. "50 Coins"
  final int value;      // e.g. 50

  RewardSegment({required this.label, required this.value});
}

// ✅ Define the reward segments list
final List<RewardSegment> rewardSegments = [
  RewardSegment(label: "50", value: 50),
  RewardSegment(label: "100", value: 100),
  RewardSegment(label: "150", value: 150),
  RewardSegment(label: "200", value: 200),
  RewardSegment(label: "250", value: 250),
  RewardSegment(label: "300", value: 300),
  RewardSegment(label: "350", value: 350),
  RewardSegment(label: "400", value: 400),
  RewardSegment(label: "450", value: 450),
  RewardSegment(label: "500", value: 500),
  RewardSegment(label: "550", value: 550),
  RewardSegment(label: "600", value: 600),
];
