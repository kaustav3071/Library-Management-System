/**
 * Modern Welcome Page JavaScript
 * Library Management System
 */

(function() {
    'use strict';

    // Wait for DOM to be ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeWelcomePage();
    });

    function initializeWelcomePage() {
        setupAnimations();
        setupInteractiveElements();
        setupStatsCounters();
        setupLoadingEffects();
    }

    // Setup staggered animations for cards
    function setupAnimations() {
        const fadeElements = document.querySelectorAll('.fade-in');
        
        fadeElements.forEach((element, index) => {
            element.style.animationDelay = (index * 0.2) + 's';
        });

        // Add intersection observer for scroll animations
        if ('IntersectionObserver' in window) {
            const observer = new IntersectionObserver((entries) => {
                entries.forEach(entry => {
                    if (entry.isIntersecting) {
                        entry.target.classList.add('fade-in');
                    }
                });
            });

            document.querySelectorAll('.feature-card, .stats-container').forEach(el => {
                observer.observe(el);
            });
        }
    }

    // Setup interactive hover effects
    function setupInteractiveElements() {
        // Stats hover effects
        document.querySelectorAll('.stat-item').forEach(item => {
            item.addEventListener('mouseenter', function() {
                this.style.transform = 'scale(1.05)';
                this.style.transition = 'all 0.3s ease';
            });
            
            item.addEventListener('mouseleave', function() {
                this.style.transform = 'scale(1)';
            });
        });

        // Feature card enhanced hover effects
        document.querySelectorAll('.feature-card').forEach(card => {
            card.addEventListener('mouseenter', function() {
                const icon = this.querySelector('.card-icon');
                if (icon) {
                    icon.style.transform = 'scale(1.1) rotate(5deg)';
                }
            });

            card.addEventListener('mouseleave', function() {
                const icon = this.querySelector('.card-icon');
                if (icon) {
                    icon.style.transform = 'scale(1) rotate(0deg)';
                }
            });
        });

        // Button ripple effect
        document.querySelectorAll('.btn-modern').forEach(button => {
            button.addEventListener('click', function(e) {
                const ripple = document.createElement('span');
                const rect = this.getBoundingClientRect();
                const size = Math.max(rect.width, rect.height);
                const x = e.clientX - rect.left - size / 2;
                const y = e.clientY - rect.top - size / 2;
                
                ripple.style.cssText = `
                    position: absolute;
                    width: ${size}px;
                    height: ${size}px;
                    left: ${x}px;
                    top: ${y}px;
                    background: rgba(255, 255, 255, 0.3);
                    border-radius: 50%;
                    transform: scale(0);
                    animation: ripple 0.6s linear;
                    pointer-events: none;
                `;
                
                this.style.position = 'relative';
                this.style.overflow = 'hidden';
                this.appendChild(ripple);
                
                setTimeout(() => {
                    ripple.remove();
                }, 600);
            });
        });
    }

    // Animated counters for stats
    function setupStatsCounters() {
        const counters = document.querySelectorAll('.stat-number');
        
        counters.forEach(counter => {
            const target = parseInt(counter.textContent.replace(/,/g, ''));
            const duration = 2000; // 2 seconds
            const step = target / (duration / 16); // 60 FPS
            let current = 0;
            
            const timer = setInterval(() => {
                current += step;
                if (current >= target) {
                    current = target;
                    clearInterval(timer);
                }
                counter.textContent = Math.floor(current).toLocaleString();
            }, 16);
        });
    }

    // Loading states for buttons
    function setupLoadingEffects() {
        document.querySelectorAll('.btn-modern').forEach(button => {
            button.addEventListener('click', function(e) {
                // Don't prevent default for navigation links
                if (!this.hasAttribute('data-no-loading')) {
                    this.classList.add('loading');
                    
                    // Remove loading state after navigation
                    setTimeout(() => {
                        this.classList.remove('loading');
                    }, 1000);
                }
            });
        });
    }

    // Utility functions
    window.WelcomePage = {
        // Add pulse effect to an element
        addPulseEffect: function(element) {
            if (typeof element === 'string') {
                element = document.querySelector(element);
            }
            if (element) {
                element.classList.add('pulse');
                setTimeout(() => {
                    element.classList.remove('pulse');
                }, 2000);
            }
        },

        // Show notification (can be enhanced with a toast library)
        showNotification: function(message, type = 'info') {
            const notification = document.createElement('div');
            notification.className = `alert alert-${type} position-fixed`;
            notification.style.cssText = `
                top: 20px;
                right: 20px;
                z-index: 9999;
                opacity: 0;
                transform: translateX(100%);
                transition: all 0.3s ease;
            `;
            notification.textContent = message;
            
            document.body.appendChild(notification);
            
            // Animate in
            setTimeout(() => {
                notification.style.opacity = '1';
                notification.style.transform = 'translateX(0)';
            }, 100);
            
            // Animate out and remove
            setTimeout(() => {
                notification.style.opacity = '0';
                notification.style.transform = 'translateX(100%)';
                setTimeout(() => {
                    notification.remove();
                }, 300);
            }, 3000);
        },

        // Update stats dynamically
        updateStats: function(stats) {
            if (stats.totalBooks) {
                const booksElement = document.querySelector('.stat-item:nth-child(1) .stat-number');
                if (booksElement) booksElement.textContent = stats.totalBooks.toLocaleString();
            }
            if (stats.activeMembers) {
                const membersElement = document.querySelector('.stat-item:nth-child(2) .stat-number');
                if (membersElement) membersElement.textContent = stats.activeMembers.toLocaleString();
            }
            if (stats.currentLoans) {
                const loansElement = document.querySelector('.stat-item:nth-child(3) .stat-number');
                if (loansElement) loansElement.textContent = stats.currentLoans.toLocaleString();
            }
        }
    };

})();

// Add CSS for ripple animation
const style = document.createElement('style');
style.textContent = `
    @keyframes ripple {
        to {
            transform: scale(4);
            opacity: 0;
        }
    }
`;
document.head.appendChild(style);