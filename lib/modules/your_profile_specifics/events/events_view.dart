import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'events_controller.dart';

class EventsView extends GetView<EventsController> {
  const EventsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                'EVENTS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      Theme.of(context).colorScheme.surface,
                    ],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.event_available,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
                  ),
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle(context, "UPCOMING EVENTS", Icons.upcoming),
            ),
          ),
          Obx(() => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = controller.upcomingEvents[index];
                return _buildEventCard(context, event);
              },
              childCount: controller.upcomingEvents.length,
            ),
          )),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            sliver: SliverToBoxAdapter(
              child: _buildSectionTitle(context, "PAST EVENTS", Icons.history),
            ),
          ),
          Obx(() => SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final event = controller.pastEvents[index];
                return _buildEventCard(context, event, isPast: true);
              },
              childCount: controller.pastEvents.length,
            ),
          )),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddEventBottomSheet(context),
        label: const Text("CREATE EVENT STUFF", style: TextStyle(letterSpacing: 1, fontWeight: FontWeight.bold)),
        icon: const Icon(Icons.add_circle_outline),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _showAddEventBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "NEW EVENT",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
              ),
              const SizedBox(height: 24),
              _buildTextField(context, controller.titleController, "Event Title", Icons.title),
              const SizedBox(height: 16),
              _buildTextField(context, controller.descController, "Description", Icons.description, maxLines: 3),
              const SizedBox(height: 16),
              _buildTextField(context, controller.locationController, "Location", Icons.location_on),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: Obx(() => OutlinedButton.icon(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now().subtract(const Duration(days: 365)),
                          lastDate: DateTime.now().add(const Duration(days: 365)),
                        );
                        if (date != null) controller.selectedDate.value = date;
                      },
                      icon: const Icon(Icons.calendar_month),
                      label: Text(DateFormat('MMM dd, yyyy').format(controller.selectedDate.value)),
                    )),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => controller.addEvent(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                    child: const Text("SAVE"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildTextField(BuildContext context, TextEditingController ctrl, String label, IconData icon, {int maxLines = 1}) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Theme.of(context).colorScheme.tertiary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
            color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(BuildContext context, Event event, {bool isPast = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 6,
                color: isPast ? Colors.grey : event.color,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: (isPast ? Colors.grey : event.color).withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              event.icon,
                              color: isPast ? Colors.grey : event.color,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              event.title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: isPast ? Colors.grey : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        event.description,
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Icon(Icons.calendar_today, size: 14, color: Theme.of(context).colorScheme.tertiary),
                          const SizedBox(width: 4),
                          Text(
                            DateFormat('MMM dd, yyyy').format(event.date),
                            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(width: 16),
                          Icon(Icons.location_on_outlined, size: 14, color: Theme.of(context).colorScheme.tertiary),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              event.location,
                              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              if (!isPast)
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Get.snackbar(
                        "Registration",
                        "Joining ${event.title}...",
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: event.color.withOpacity(0.8),
                        colorText: Colors.white,
                      );
                    },
                    child: Container(
                      width: 50,
                      color: event.color.withOpacity(0.05),
                      child: Center(
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                          color: event.color,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
