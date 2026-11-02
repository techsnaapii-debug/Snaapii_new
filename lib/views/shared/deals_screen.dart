import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/auth_api.dart';
import '../../services/collaboration_api.dart';

class DealsScreen extends StatefulWidget {
  const DealsScreen({super.key, required this.isCreator});
  final bool isCreator;

  @override
  State<DealsScreen> createState() => _DealsScreenState();
}

class _DealsScreenState extends State<DealsScreen> {
  List<Map<String, dynamic>> _deals = const [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final deals = await CollaborationApi.deals();
      if (mounted) setState(() => _deals = deals);
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Collaborations'),
      foregroundColor: const Color(0xFF6B4EFF),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
    body: RefreshIndicator(
      onRefresh: _load,
      child: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _StateCard(message: _error!, onRetry: _load)
          : _deals.isEmpty
          ? const _StateCard(message: 'No collaborations yet.')
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _deals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (_, index) => _card(_deals[index]),
            ),
    ),
  );

  Widget _card(Map<String, dynamic> deal) {
    final id = int.tryParse((deal['id'] ?? deal['deal_id']).toString());
    final partner = widget.isCreator
        ? deal['brand_name']?.toString() ?? 'Brand'
        : deal['creator_name']?.toString() ?? 'Creator';
    final status =
        deal['deal_status']?.toString().replaceAll('_', ' ') ?? 'pending';
    final amount =
        deal['agreed_amount'] ?? deal['offered_amount'] ?? deal['amount'];
    return Card(
      child: ListTile(
        enabled: id != null,
        onTap: id == null
            ? null
            : () async {
                await Get.to(
                  () => DealConversationScreen(
                    dealId: id,
                    isCreator: widget.isCreator,
                  ),
                );
                _load();
              },
        leading: CircleAvatar(
          child: Text(partner.substring(0, 1).toUpperCase()),
        ),
        title: Text(deal['campaign_name']?.toString() ?? 'Campaign'),
        subtitle: Text(
          '$partner · ${status[0].toUpperCase()}${status.substring(1)}',
        ),
        trailing: amount == null
            ? const Icon(Icons.chevron_right)
            : Text('₹$amount'),
      ),
    );
  }
}

class DealConversationScreen extends StatefulWidget {
  const DealConversationScreen({
    super.key,
    required this.dealId,
    required this.isCreator,
  });
  final int dealId;
  final bool isCreator;

  @override
  State<DealConversationScreen> createState() => _DealConversationScreenState();
}

class _DealConversationScreenState extends State<DealConversationScreen> {
  final _message = TextEditingController();
  Map<String, dynamic>? _detail;
  List<Map<String, dynamic>> _messages = const [];
  bool _loading = true;
  bool _sending = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _message.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final result = await Future.wait<Object>([
        CollaborationApi.deal(widget.dealId),
        CollaborationApi.messages(widget.dealId),
      ]);
      if (mounted) {
        setState(() {
          _detail = result[0] as Map<String, dynamic>;
          _messages = result[1] as List<Map<String, dynamic>>;
        });
      }
    } on ApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _send() async {
    final text = _message.text.trim();
    if (text.isEmpty || _sending) return;
    await _run(() => CollaborationApi.sendMessage(widget.dealId, text));
    if (mounted) _message.clear();
  }

  Future<void> _offer() async {
    final amount = TextEditingController();
    final note = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Make an offer'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: amount,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            TextField(
              controller: note,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Message (optional)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final parsed = num.tryParse(amount.text.trim());
              if (parsed == null || parsed <= 0) return;
              Navigator.pop(dialogContext);
              await _run(
                () => CollaborationApi.makeOffer(
                  dealId: widget.dealId,
                  amount: parsed,
                  message: note.text,
                ),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
    amount.dispose();
    note.dispose();
  }

  Future<void> _submitLinks() async {
    final links = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Submit Instagram links'),
        content: TextField(
          controller: links,
          maxLines: 4,
          decoration: const InputDecoration(hintText: 'One link per line'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final values = links.text
                  .split(RegExp(r'\r?\n'))
                  .map((value) => value.trim())
                  .where((value) => value.isNotEmpty)
                  .toList();
              if (values.isEmpty) return;
              Navigator.pop(dialogContext);
              await _run(
                () => CollaborationApi.submitLinks(widget.dealId, values),
              );
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
    links.dispose();
  }

  Future<void> _disapprove() async {
    final reason = TextEditingController();
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Request changes'),
        content: TextField(
          controller: reason,
          maxLines: 3,
          decoration: const InputDecoration(labelText: 'Reason (optional)'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await _run(
                () => CollaborationApi.disapproveLinks(
                  widget.dealId,
                  reason: reason.text,
                ),
              );
            },
            child: const Text('Send request'),
          ),
        ],
      ),
    );
    reason.dispose();
  }

  Future<void> _run(Future<void> Function() action) async {
    if (_sending) return;
    setState(() => _sending = true);
    try {
      await action();
      if (mounted) _notice('Saved successfully.');
      await _load();
    } on ApiException catch (error) {
      if (mounted) _notice(error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  Future<void> _createPaymentOrder() async {
    if (_sending) return;
    setState(() => _sending = true);
    try {
      await CollaborationApi.initiatePayment(widget.dealId);
      if (mounted) {
        _notice('Payment order created. Complete checkout through Cashfree.');
        await _load();
      }
    } on ApiException catch (error) {
      if (mounted) _notice(error.message);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  void _notice(String text) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

  @override
  Widget build(BuildContext context) {
    final detail = _detail;
    final deal = detail?['deal'] is Map
        ? Map<String, dynamic>.from(detail!['deal'])
        : const <String, dynamic>{};
    final offer = detail?['latest_offer'] is Map
        ? Map<String, dynamic>.from(detail!['latest_offer'])
        : null;
    final submission = detail?['submission'] is Map
        ? Map<String, dynamic>.from(detail!['submission'])
        : null;
    final partner = widget.isCreator
        ? deal['brand_name']?.toString() ?? 'Brand'
        : deal['creator_name']?.toString() ?? 'Creator';
    return Scaffold(
      appBar: AppBar(
        title: Text(partner),
        foregroundColor: const Color(0xFF6B4EFF),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
          ? _StateCard(message: _error!, onRetry: _load)
          : Column(
              children: [
                _summary(deal, offer, submission),
                Expanded(
                  child: _messages.isEmpty
                      ? const Center(child: Text('No messages yet.'))
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: _messages.length,
                          itemBuilder: (_, index) {
                            final item = _messages[index];
                            final mine =
                                item['sender_role']?.toString() ==
                                (widget.isCreator ? 'creator' : 'brand');
                            return Align(
                              alignment: mine
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 8),
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: mine
                                      ? const Color(0xFFE9DDFE)
                                      : const Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(item['content']?.toString() ?? ''),
                              ),
                            );
                          },
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _message,
                          enabled: !_sending,
                          decoration: const InputDecoration(
                            hintText: 'Write a message',
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _sending ? null : _send,
                        icon: const Icon(Icons.send, color: Color(0xFF6B4EFF)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _summary(
    Map<String, dynamic> deal,
    Map<String, dynamic>? offer,
    Map<String, dynamic>? submission,
  ) {
    final role = widget.isCreator ? 'creator' : 'brand';
    final isNegotiating = deal['deal_status']?.toString() == 'negotiating';
    final canAcceptOffer =
        offer?['offer_status']?.toString() == 'pending' &&
        offer?['made_by_role']?.toString() != role;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFF8F6FF),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            deal['campaign_name']?.toString() ?? 'Campaign',
            style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
          ),
          Text(
            'Status: ${(deal['deal_status']?.toString() ?? 'pending').replaceAll('_', ' ')}',
          ),
          if (offer != null)
            Text(
              'Latest offer: ₹${offer['amount'] ?? offer['offer_amount'] ?? '—'}',
            ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              if (isNegotiating)
                OutlinedButton(
                  onPressed: _sending ? null : _offer,
                  child: const Text('Make offer'),
                ),
              if (canAcceptOffer)
                OutlinedButton(
                  onPressed: _sending
                      ? null
                      : () => _run(
                          () => CollaborationApi.acceptOffer(widget.dealId),
                        ),
                  child: const Text('Accept offer'),
                ),
              if (!widget.isCreator &&
                  deal['deal_status']?.toString() == 'accepted')
                OutlinedButton(
                  onPressed: _sending ? null : _createPaymentOrder,
                  child: const Text('Create payment order'),
                ),
              if (widget.isCreator)
                OutlinedButton(
                  onPressed: _sending ? null : _submitLinks,
                  child: const Text('Submit links'),
                ),
              if (!widget.isCreator && submission != null) ...[
                OutlinedButton(
                  onPressed: _sending
                      ? null
                      : () => _run(
                          () => CollaborationApi.approveLinks(widget.dealId),
                        ),
                  child: const Text('Approve links'),
                ),
                OutlinedButton(
                  onPressed: _sending ? null : _disapprove,
                  child: const Text('Request changes'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _StateCard extends StatelessWidget {
  const _StateCard({required this.message, this.onRetry});
  final String message;
  final Future<void> Function()? onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(message, textAlign: TextAlign.center),
          if (onRetry != null)
            TextButton(onPressed: onRetry, child: const Text('Try again')),
        ],
      ),
    ),
  );
}
