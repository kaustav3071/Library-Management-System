/**
 * Modern Books Page JavaScript
 * Library Management System
 */

(function() {
    'use strict';

    // Wait for DOM to be ready
    document.addEventListener('DOMContentLoaded', function() {
        initializeBooksPage();
    });

    function initializeBooksPage() {
        setupAnimations();
        setupFormEnhancements();
        setupTableEnhancements();
        setupValidationEnhancements();
    }

    // Setup staggered animations
    function setupAnimations() {
        const fadeElements = document.querySelectorAll('.fade-in');
        
        fadeElements.forEach((element, index) => {
            element.style.animationDelay = (index * 0.2) + 's';
        });
    }

    // Enhanced form interactions
    function setupFormEnhancements() {
        // Auto-focus first input
        const firstInput = document.querySelector('#txtTitle');
        if (firstInput) {
            firstInput.focus();
        }

        // Enhanced button interactions
        const addButton = document.querySelector('#btnAdd');
        if (addButton) {
            addButton.addEventListener('click', function() {
                this.classList.add('loading');
                setTimeout(() => {
                    this.classList.remove('loading');
                }, 2000);
            });
        }

        // Input formatting for ISBN
        const isbnInput = document.querySelector('#txtISBN');
        if (isbnInput) {
            isbnInput.addEventListener('input', function() {
                // Remove non-alphanumeric characters except hyphens and X
                this.value = this.value.replace(/[^0-9Xx-]/g, '');
            });

            isbnInput.addEventListener('blur', function() {
                // Format ISBN with hyphens if it's a valid length
                const value = this.value.replace(/[^0-9Xx]/g, '');
                if (value.length === 10 || value.length === 13) {
                    // Basic ISBN formatting
                    if (value.length === 13) {
                        this.value = value.replace(/(\d{3})(\d{1})(\d{3})(\d{3})(\d{3})/, '$1-$2-$3-$4-$5');
                    }
                }
            });
        }

        // Form field animations
        document.querySelectorAll('.form-control').forEach(input => {
            input.addEventListener('focus', function() {
                this.parentElement.classList.add('focused');
            });

            input.addEventListener('blur', function() {
                this.parentElement.classList.remove('focused');
                if (this.value) {
                    this.parentElement.classList.add('has-value');
                } else {
                    this.parentElement.classList.remove('has-value');
                }
            });
        });
    }

    // Enhanced table interactions
    function setupTableEnhancements() {
        const table = document.querySelector('#gvBooks');
        if (table) {
            // Add hover effects to rows
            const rows = table.querySelectorAll('tbody tr');
            rows.forEach(row => {
                row.addEventListener('mouseenter', function() {
                    this.style.transform = 'scale(1.02)';
                    this.style.boxShadow = '0 5px 15px rgba(0,0,0,0.1)';
                });

                row.addEventListener('mouseleave', function() {
                    this.style.transform = 'scale(1)';
                    this.style.boxShadow = 'none';
                });
            });

            // Add book count display
            const bookCount = rows.length;
            const header = document.querySelector('.table-container h3');
            if (header && bookCount > 0) {
                const badge = document.createElement('span');
                badge.className = 'badge badge-secondary ml-2';
                badge.textContent = bookCount + ' books';
                header.appendChild(badge);
            }
        }
    }

    // Enhanced validation feedback
    function setupValidationEnhancements() {
        // Real-time validation feedback
        document.querySelectorAll('[data-val="true"]').forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });

            input.addEventListener('input', function() {
                // Clear previous validation on input
                clearValidation(this);
            });
        });
    }

    function validateField(field) {
        const validators = document.querySelectorAll(`[controltovalidate="${field.id}"]`);
        let isValid = true;

        validators.forEach(validator => {
            if (validator.style.display !== 'none') {
                field.classList.add('is-invalid');
                field.classList.remove('is-valid');
                isValid = false;
            }
        });

        if (isValid && field.value.trim()) {
            field.classList.add('is-valid');
            field.classList.remove('is-invalid');
        }
    }

    function clearValidation(field) {
        field.classList.remove('is-valid', 'is-invalid');
    }

    // Utility functions
    window.BooksPage = {
        // Show success message
        showSuccess: function(message) {
            const alert = document.createElement('div');
            alert.className = 'alert alert-success alert-dismissible fade show';
            alert.innerHTML = `
                <i class="fas fa-check-circle mr-2"></i>
                ${message}
                <button type="button" class="close" data-dismiss="alert">
                    <span>&times;</span>
                </button>
            `;
            
            const container = document.querySelector('.form-container');
            container.insertBefore(alert, container.firstChild);
            
            setTimeout(() => {
                alert.remove();
            }, 5000);
        },

        // Clear form
        clearForm: function() {
            document.querySelectorAll('.form-control').forEach(input => {
                input.value = '';
                input.classList.remove('is-valid', 'is-invalid');
            });
            
            const firstInput = document.querySelector('#txtTitle');
            if (firstInput) {
                firstInput.focus();
            }
        },

        // Search functionality
        searchBooks: function(searchTerm) {
            const table = document.querySelector('#gvBooks');
            if (!table) return;

            const rows = table.querySelectorAll('tbody tr');
            const term = searchTerm.toLowerCase();

            rows.forEach(row => {
                const text = row.textContent.toLowerCase();
                if (text.includes(term)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        }
    };

})();